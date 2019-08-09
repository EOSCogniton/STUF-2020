/***************************************************************************
   
   Function name: Grear_Update
   
   Author:        Martín Gómez-Valcárcel (MGV)
   
   Descriptions:  Grear_Update receives the gear the engine is in and, from
                  PINS_GEAR, determines which segments it has to illuminate
                  so that the pilot knows the gear he's in.
                            
***************************************************************************/
#include "Screen128x64.h"
#include "U8glib.h"


/**************************************************************************/
//    Internal variables and constants used ONLY by the functions in this file
/**************************************************************************/

U8GLIB_ST7920_128X64_1X u8g(23, 17, 16,U8G_PIN_NONE);

/**************************************************************************/
//    Functions
/**************************************************************************/

void u8g_prepare(void) {
  u8g.setFont(u8g_font_fub30);
  u8g.setFontRefHeightExtendedText();
  u8g.setDefaultForegroundColor();
  u8g.setFontPosTop();
}



    

void Screen_Init(){
  const char logoEPSA[][4] = {"E","EP","EPS","EPSA"};
    for (int i = 0; i<= 3; i++){
      u8g.firstPage();
      do {
        u8g_prepare();
        u8g.drawStr(10,5,logoEPSA[i]);
      } while( u8g.nextPage() ); 
  }
}



void Screen_Update(signed Gear){
  u8g.firstPage();  
  do {
    u8g.drawBox(50,40,20,20);
    u8g_prepare();
  } while( u8g.nextPage() );
  delay(1000);  
}



/***************************************************************************
  END FILE
***************************************************************************/
