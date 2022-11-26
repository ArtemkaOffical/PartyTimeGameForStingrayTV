import "js/constants.js" as cc;
Delegate
{
	id: categoryDelegate;
	width: categoryText.width;
	height: categoryText.height;
	focus: true;
	Button
	{
		id: categoryText;
		width:300;
		text: model.title;
	}
}
