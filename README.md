# Sample code - Upload Image with Vapor and TinyMCE Plugin
a little project to understand how works uploading images with TinyMCE, based on CodexWorld Tutorial.


## Links

* [How to Upload Image in TinyMCE Editor using PHP](https://www.codexworld.com/tinymce-upload-image-to-server-using-php/) - CodexWorld
* [Vapor](https://vapor.codes/) - A server-side Swift web framework.
* [TinyMCE](https://www.tiny.cloud/) - a full-featured rich text editor.

## Tips
* Do not forget to escape the } character in leaf page with \} if I use #get or #embed. The TinyMCE.init script is cut with a leaf tag. Not needed if I don't use the leaf tags.
* The struct with the POST content has a variable of type 'File', which has 2 attributes 'data' and 'filename'.
* The upload POST handler must give back a response with the path of image on the server (location: path)

#### License - MIT


