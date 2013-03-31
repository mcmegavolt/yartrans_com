/*
Copyright (c) 2003-2010, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/
/*
	Sample configuration file has been written by Vytenis Urbonavičius (UAB, "VISAITA"; Lithuania)
	It is very much based on the official documentation, which can be found here:
		http://docs.cksource.com/ckeditor_api/symbols/CKEDITOR.config.html
	Please, do not remove this comment when working with sample config file.
*/
CKEDITOR.editorConfig=function(e){e.filebrowserBrowseUrl="/ckeditor/attachment_files",e.filebrowserFlashBrowseUrl="/ckeditor/attachment_files",e.filebrowserFlashUploadUrl="/ckeditor/attachment_files",e.filebrowserImageBrowseLinkUrl="/ckeditor/pictures",e.filebrowserImageBrowseUrl="/ckeditor/pictures",e.filebrowserImageUploadUrl="/ckeditor/pictures",e.filebrowserUploadUrl="/ckeditor/attachment_files",e.language="ru",e.emailProtection="encode",e.enterMode=CKEDITOR.ENTER_P,e.height="450",e.resize_dir="vertical",e.shiftEnterMode=CKEDITOR.ENTER_DIV,e.toolbar=[["Source","-","Preview"],["Cut","Copy","Paste","PasteText","PasteFromWord"],["Undo","Redo","-","RemoveFormat"],["Format"],["TextColor","BGColor"],["Maximize","ShowBlocks"],"/",["JustifyLeft","JustifyCenter","JustifyRight"],["Bold","Italic","Underline","Strike","-","Subscript","Superscript"],["NumberedList","BulletedList","-","Outdent","Indent","Blockquote","CreateDiv"],["Link","Unlink","Anchor"],["Image","Flash","Table","HorizontalRule","SpecialChar"]],e.width=770};