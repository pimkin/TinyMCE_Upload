import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    
    // Route for the index page (show all the saved articles)
    router.get("/") { req throws -> Future<View> in
        return Article.query(on: req).all().flatMap(to: View.self) { articles in
            let context = IndexContext(articles: articles)
            return try req.view().render("index", context)
        }
    }
    
    // Route for the createArticle page
    router.get("createArticle") { req throws -> Future<View> in
        return try req.view().render("createArticle")
    }
    
    // Route for the POST createArticle
    // (just create an article with the content received, save it and redirect to "/"
    // to display the index page
    router.post(ArticleData.self, at:"createArticle") { req, data throws -> Future<Response> in
        return Article(content: data.content).save(on: req).transform(to: req.redirect(to: "/"))
    }
    
    // Route to get an saved image in the Images folder
    router.get("Images", String.parameter) { req throws -> Future<Response> in
     
        // get the filename in the url (Images/filename)
        let imagePath = try req.parameters.next(String.self)
        // Construct the path for the image
        let path = DirectoryConfig.detect().workDir + "Images/" + imagePath
        
        return try req.streamFile(at: path)
        
    }
    
    // Route to handle the POST request for the upload of an image
    // TinyMCE.init -> xhr.open('POST', 'upload');
    // Receive a File data type
    router.post(ImageData.self, at: "upload") { req, data throws -> Future<JSONResponse> in
        
        let filename = data.file.filename
        let pictureData = data.file.data
        
        let workPath = DirectoryConfig.detect().workDir
        let imagePath = workPath + "Images/" + filename
        
        print("imagePath: \(imagePath)")
        FileManager().createFile(atPath: imagePath,
                                 contents: pictureData, attributes: nil)
        
        
        // Give a response with the location of the image on the server
        let jsonResponse = JSONResponse(location: "Images/" + filename)
        
        return req.future(jsonResponse)
        
    }
    
}

// content of the POST request for upload
// TinyMCE.init -> formData.append('file', blobInfo.blob(), blobInfo.filename());
struct ImageData: Content {
    let file: File
}

// response needed of the POST request
// TinyMCE.init -> if (!json || typeof json.location != 'string') {
struct JSONResponse: Content {
    let location: String
}

// Content of the POST request for createArticle
struct ArticleData: Content {
    let content: String // name="content" in the HTML <Textarea>
}

// Context for the index page
struct IndexContext: Encodable {
    let articles: [Article] // use in leaf page
}
