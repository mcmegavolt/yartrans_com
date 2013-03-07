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

  config.language = 'ru';

	config.emailProtection = 'encode';
		
	config.enterMode = CKEDITOR.ENTER_P;
		
	// config.forcePasteAsPlainText = false;
		
		
	config.height = '450';
		
	config.resize_dir = 'vertical';
		
		
	// The minimum editor width, in pixels, when resizing it with the resize handle.
		// config.resize_minWidth = 750;
		
		
	config.shiftEnterMode = CKEDITOR.ENTER_DIV;
		
		
	// The toolbar definition. It is an array of toolbars (strips), each one being also an array, containing a list of UI items. Note that this setting is composed by "toolbar_" added by the toolbar name, which in this case is called "Basic". This second part of the setting name can be anything. You must use this name in the CKEDITOR.config.toolbar setting, so you instruct the editor which toolbar_(name) setting to you. 
		/*
		config.toolbar_Basic = [
			[ 'Source', '-', 'Bold', 'Italic' ]
		];
		*/
		
		
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