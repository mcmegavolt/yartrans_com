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

CKEDITOR.editorConfig = function( config )
{


	/* Filebrowser routes */
  // The location of an external file browser, that should be launched when "Browse Server" button is pressed.
  config.filebrowserBrowseUrl = "/ckeditor/attachment_files";

  // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Flash dialog.
  config.filebrowserFlashBrowseUrl = "/ckeditor/attachment_files";

  // The location of a script that handles file uploads in the Flash dialog.
  config.filebrowserFlashUploadUrl = "/ckeditor/attachment_files";
  
  // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Link tab of Image dialog.
  config.filebrowserImageBrowseLinkUrl = "/ckeditor/pictures";

  // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Image dialog.
  config.filebrowserImageBrowseUrl = "/ckeditor/pictures";

  // The location of a script that handles file uploads in the Image dialog.
  config.filebrowserImageUploadUrl = "/ckeditor/pictures";
  
  // The location of a script that handles file uploads.
  config.filebrowserUploadUrl = "/ckeditor/attachment_files";

  config.language = 'ru';

	config.emailProtection = 'encode';
		
	config.enterMode = CKEDITOR.ENTER_P;
		
	// config.forcePasteAsPlainText = false;
		
		
	config.height = '450';
		
	config.resize_dir = 'vertical';
		
		
	// The minimum editor width, in pixels, when resizing it with the resize handle.
		// config.resize_minWidth = 750;
		
		
	config.shiftEnterMode = CKEDITOR.ENTER_DIV;
		
	// This is the default toolbar definition used by the editor. It contains all editor features.
		
		config.toolbar =
		[
			['Source','-','Preview'],
			['Cut','Copy','Paste','PasteText','PasteFromWord'],
			['Undo','Redo','-','RemoveFormat'],
			['Format'],
			['TextColor','BGColor'],
			['Maximize', 'ShowBlocks'],
			'/',

			['JustifyLeft','JustifyCenter','JustifyRight'],
			['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
			
			['NumberedList','BulletedList','-','Outdent','Indent','Blockquote','CreateDiv'],
			
			['Link','Unlink','Anchor'],
			['Image','Flash','Table','HorizontalRule','SpecialChar']
			
		];
		
	// The editor width in CSS size format or pixel integer.
		config.width = 770;
		// config.width = '75%';
		// config.width = '';
	
};