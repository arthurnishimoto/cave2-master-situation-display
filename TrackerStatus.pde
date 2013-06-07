void drawTrackerStatus()
{
  systemText = "TRACKING SYSTEM";
  
  CAVE2_Scale = 65;
  CAVE2_displayMode = DISPLAY;
  
  translate( 50, 60 );
  
  fill(0,250,250);
  text("CAVE2(TM) System Master Situation Display (Version 0.4 - alpha)", 16, 16);
  
  float timeSinceLastTrackerUpdate = programTimer - lastTrackerUpdateTime;
  
  if( connectToTracker )
  {
    text("Connected to '"+ trackerIP + "' on msgport: " + msgport, 16, 16 * 2);
    text("Receiving data on dataport: " + dataport, 16, 16 * 3);
  }
  else
  {
    text("Not connected to tracker", 16, 16 * 2);
    text("Running in demo mode", 16, 16 * 3);
  }
  
  if( timeSinceLastTrackerUpdate >= 5 )
  {
    fill(250,250,50);
    text("No active controllers or trackables in CAVE2", 16, 16 * 4);
    
    if( timeSinceLastInteractionEvent >= 30 )
    {
      //CAVE2_3Drotation.x = constrain( CAVE2_3Drotation.x + deltaTime * 0.1, 0, radians(45) );
      //CAVE2_3Drotation.y += deltaTime * 0.1;
      //demoMode = true;
    }
  }
  else
  {
    
    //demoMode = false;
  }
  
  popMatrix();
  
  if( demoMode )
  {
    CAVE2_3Drotation.x = constrain( CAVE2_3Drotation.x + deltaTime * 0.1, 0, radians(45) );
    CAVE2_3Drotation.y += deltaTime * 0.1;
  }
  
  /*
  if( timeSinceLastTrackerUpdate < 2 )
  {
    text("Connected to '"+ trackerIP + "' on msgport: " + msgport, 16, 16 * 2);
    text("Receiving data on dataport: " + dataport, 16, 16 * 3);
    reconnectTrackerTimer = programTimer + reconnectTrackerDelay;
  }
  else
  {
    fill(250,50,50);
    text("LOST CONNECTION TO '"+ trackerIP + "' on msgport: " + msgport, 16, 16 * 2);
    text("TIME SINCE LAST UPDATE: " + timeSinceLastTrackerUpdate, 16, 16 * 3);
    
    float reconnectTimer = reconnectTrackerTimer - programTimer;
    
    
    if( reconnectTimer > 1 )
    {
      text("CHECK OMEGALIB - OINPUTSERVER STATUS", 16, 16 * 4);
      text("ATTEMPTING RECONNECT IN " + (int)reconnectTimer , 16, 16 * 5);
      connectionTime = programTimer;
    }
    else
    {
      text("CHECK OMEGALIB - OINPUTSERVER STATUS", 16, 16 * 4);
      //text("ATTEMPTING RECONNECT - MAY HANG FOR 70 SECONDS", 16, 16 * 4);
      //text("OR UNTIL OINPUTSERVER CONNECTION IS ESTABLISHED", 16, 16 * 5);
      connectionTimer = programTimer - connectionTime;
      
      if( reconnectTimer < 0 )
      {
        //this.unregisterDispose(omicronManager);
        //omicronManager.ConnectToTracker(dataport, msgport, trackerIP);
        //reconnectTrackerTimer = millis() / 1000.0 + reconnectTrackerDelay;
      }
    }
    
    if( connectionTimer < 5 )
    {
      background(24);
      fill(0,250,250);
      text("CAVE2(TM) System Locator (Version 0.2 - alpha)", 16, 16);
      text("Connected to '"+ trackerIP + "' on msgport: " + msgport, 16, 16 * 2);
      text("Receiving data on dataport: " + dataport, 16, 16 * 3);
      //reconnectTrackerTimer = programTimer + reconnectTrackerDelay;
      
      fill(250,250,50);
      text("No active controllers or trackables in CAVE2", 16, 16 * 4);
    }
    
    
  }*/
  
  
  // Draw CAVE2 ------------------------------------------------------------------
  pushMatrix();
  translate( CAVE2_screenPos.x, CAVE2_screenPos.y, CAVE2_worldZPos);
  rotateX( CAVE2_3Drotation.x ); 
  rotateZ( CAVE2_3Drotation.y );
  scale( 2, 2, 2 );
  translate( 0, 0, CAVE2_screenPos.z );
  
  drawCAVE2();
  
  // CAVE2 diameter (inner-screen, outer ring) - upper ring
  drawSpeakers();
  drawSounds();
  
  // -----------------------------------------------------------------------------
  wandTrackable4.update();
  wandTrackable3.update();
  wandTrackable2.draw();
  wandTrackable1.draw();
  headTrackable.draw();
  
  drawCoordinateSystem( 0, 0 );
  popMatrix();
  
  headButton.fillColor = headTrackable.currentStatusColor;
  wandButton1.fillColor = wandTrackable1.currentStatusColor;
  wandButton2.fillColor = wandTrackable2.currentStatusColor;
  wandButton3.fillColor = wandTrackable3.colorDisabled;
  wandButton4.fillColor = wandTrackable4.colorDisabled;
  
  /*
  headButton.draw();
  wandButton1.draw();
  wandButton2.draw();
  wandButton3.draw();
  wandButton4.draw();
  */
  
  PVector trackableWindow = new PVector( width * 0.02, height - 400 );
  float displayWindowSpacing = 800;
  displayTrackableWindow( headTrackable, trackableWindow.x, trackableWindow.y );
  displayControllerWindow( wandTrackable1, trackableWindow.x + displayWindowSpacing, trackableWindow.y );
  displayControllerWindow( wandTrackable2, trackableWindow.x + displayWindowSpacing * 2, trackableWindow.y );
  
  /*
  if( headButton.selected )
  {
    headTrackable.selected = true;
    wandTrackable1.selected = false;
    wandTrackable2.selected = false;
    wandTrackable3.selected = false;
    wandTrackable4.selected = false;
    
    displayTrackableWindow( headTrackable, trackableWindow.x, trackableWindow.y );
    wandButton1.selected = false;
    wandButton2.selected = false;
    wandButton3.selected = false;
    wandButton4.selected = false;
  }
  else if( wandButton1.selected )
  {
    displayControllerWindow( wandTrackable1, trackableWindow.x, trackableWindow.y );
    headButton.selected = false;
    wandButton2.selected = false;
    wandButton3.selected = false;
    wandButton4.selected = false;
    
    headTrackable.selected = false;
    wandTrackable1.selected = true;
    wandTrackable2.selected = false;
    wandTrackable3.selected = false;
    wandTrackable4.selected = false;
  }
  else if( wandButton2.selected )
  {
    displayControllerWindow( wandTrackable2, trackableWindow.x, trackableWindow.y );
    headButton.selected = false;
    wandButton1.selected = false;
    wandButton3.selected = false;
    wandButton4.selected = false;
    
    headTrackable.selected = false;
    wandTrackable1.selected = false;
    wandTrackable2.selected = true;
    wandTrackable3.selected = false;
    wandTrackable4.selected = false;
  }
  else if( wandButton3.selected )
  {
    displayControllerWindow( wandTrackable3, trackableWindow.x, trackableWindow.y );
    headButton.selected = false;
    wandButton1.selected = false;
    wandButton2.selected = false;
    wandButton3.selected = true;
    wandButton4.selected = false;
    
    headTrackable.selected = false;
    wandTrackable1.selected = false;
    wandTrackable2.selected = false;
    wandTrackable3.selected = true;
    wandTrackable4.selected = false;
  }
  else if( wandButton4.selected )
  {
    displayControllerWindow( wandTrackable4, trackableWindow.x, trackableWindow.y );
    headButton.selected = false;
    wandButton1.selected = false;
    wandButton2.selected = false;
    wandButton3.selected = false;
    wandButton4.selected = true;
    
    headTrackable.selected = false;
    wandTrackable1.selected = false;
    wandTrackable2.selected = false;
    wandTrackable3.selected = false;
    wandTrackable4.selected = true;
  }
  */
}