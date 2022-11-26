import "js/constants.js" as constants;

Delegate
{
	id: musicDelegate;
	width:  constants.poster["width"];
	height:constants.poster["height"] ;
	opacity: activeFocus ? 1.0 : 0.5;
	focus: true;
	Button
	{
		
		width:  parent.width+5;
		height: parent.height+5;
		anchors.fill:parent;
		Image
		{
			id: posterDefaultImage;
			width:  constants.poster["width"]-15;
			height:constants.poster["height"]-15;
			anchors.centerIn:parent;
			registerInCacheSystem: false;
			source: model.poster;
			fillMode: Stretch;
		}
		BodyText 
		{
			
			id: dd;
		
			width:  musicDelegate.width+15;
			anchors.top:posterDefaultImage.bottom;
			anchors.topMargin:10;
			font: secondaryFont;
			
			text: model.name.toUpperCase();
			color: colorTheme.activeTextColor;
			wrapMode:Wrap;
		}
	}
	
}