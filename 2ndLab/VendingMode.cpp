#include <Core/Utils/AsciiConverter.h>
#include <Core/Log/Log.h>
#include "VendingScreen.h"
#include "Gui.h"

extern "C"{
	u16 calculate_change(u16 price, u16 money){
		u16 change = 0;
		change = money - price;
		if (money > price){ 
			RB_LOG_DEBUG("cents: " << change);
		}
		return 0;
	}
}

void VendingScreen::drawChangeInfo( u16 price, u16 money )
{
	const Gui::CoordinateType left = 15;
	const Gui::CoordinateType right = Gui::Display::getWidth() - 15;
	const Gui::CoordinateType tright = Gui::Display::getWidth() - 10;
	const Gui::CoordinateType Line = 5 + ( ( Gui::Display::getHeight() - 10 ) / 4 * 4);
	u16 change;
	Gui::paint(
      GuiResources::getInstanceRef().fontArial20.text( "Change: " ),
      Gui::LeftAlign( left ),
      Gui::CenterVertical( Line ),
      GuiColorMap::FOREGROUND
    );
	change = calculate_change(price, money);
	if (price>money){
		change = 0;
	}
	else{
		change = money-price;
	}
	drawMoneyValue( GuiResources::getInstanceRef().fontArial20, tright, Line, change);
	Gui::update();
}
