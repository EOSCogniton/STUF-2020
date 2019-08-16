#define GEAR_UPDATE_H



/**************************************************************************/
//    Inclusion of the necessary libraries
/**************************************************************************/

#include "U8glib.h"
#include "Arduino.h"


/**************************************************************************/
//    External variables and constants used by the functions in this file
/**************************************************************************/


/**************************************************************************/
//    Functions
/**************************************************************************/
void u8g_prepare();

void Screen_Init();

void Screen_Update(signed Gear);
/*
    @brief      Grear_Update receives the gear the engine is in and, from
                PINS_GEAR, determines which segments it has to illuminate
                so that the pilot knows the gear he's in.
    @param[in]  Gear
    @return     It uses a function given by the manufacturer of the
                microcontroller to tell if the n-connector pins should
                send current or not.
*/
