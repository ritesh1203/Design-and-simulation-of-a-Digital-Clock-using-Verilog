`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.08.2023 15:43:35
// Design Name: 
// Module Name: Digital_clock
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Digital_clock( clock_sec,reset,set_time,set_hour,set_minute,set_am_pm,alarm_hour,
alarm_minute,alarm_am_pm,stopwatch_on,stopwatch_reset,seconds,minutes,hours,am_pm,stopwatch_hours,stopwatch_minutes,stopwatch_seconds,alarm_ringing);

// inputs
input clock_sec; //clock with frequency of 1Hz and time period 1sec.
input reset;     // Active high asynchronous reset
input set_time;
input set_am_pm;  // to set am or pm. here set_am_pm =1 for pm and set_am_pm=0 for am. 
input alarm_am_pm;
input stopwatch_on;
input stopwatch_reset;
input[3:0] set_hour;
input[5:0] set_minute;
input[3:0] alarm_hour;
input[5:0] alarm_minute;

// outputs

output am_pm;
output alarm_ringing;
output[3:0] hours;
output[5:0] minutes;
output[5:0] seconds;
output[4:0] stopwatch_hours;
output[5:0] stopwatch_minutes;
output[5:0] stopwatch_seconds;

//using these as reg 
reg am_pm;
reg alarm_ringing=0;
reg[3:0] hours;
reg[4:0] stopwatch_hours;
reg[5:0] minutes;
reg[5:0] seconds;
reg[5:0] stopwatch_minutes;
reg[5:0] stopwatch_seconds;

always@(posedge clock_sec,posedge reset,posedge set_time)    // This block will work when any of the clock_sec, reset, set_time will go from 0 to 1 (positive edge)
begin
if(reset)                                               // cheack for active high reset in order to reset the time.
    begin
    hours=12;
    minutes=0;
    seconds=0;
    am_pm=0;
    end
else if(set_time)                                  //set_time will be active high to set a particular time manually in the clock.
    begin
    seconds=0;
    minutes=set_minute;
    hours=set_hour;
    am_pm= set_am_pm;
    end
else if(clock_sec)                                 //beginning of each sec.
    begin
    seconds=seconds+1;                            // increment in second
    if(seconds==60)                               // check for maximum value of seconds.
        begin
        seconds=0;                                // reset seconds 
        minutes=minutes+1;                       // increment in minutes
        if(minutes==60)                         // cheack maximum value of minutes
            begin
            minutes=0;                         // reset minutes
            hours=hours+1;                     // increment hours
            if(hours==12)                      //  cheack for maximum value of hour
                begin
                am_pm = ~ am_pm;               // changing am to pm or vice-versa.
                end
            else if(hours==13)    
                begin
                hours = 1;
                end
            end
        end        
      
    end
end

 
 
always@(clock_sec)                      // comparing Alarm time with the present time.                                      
begin                                   //  if both the time will be same then it will give alarm _ringing as active high.
if((hours==alarm_hour)&&(minutes==alarm_minute)&&(am_pm==alarm_am_pm))
   alarm_ringing=1'b1;
else alarm_ringing=1'b0;

end

// for stopwatch

always@(posedge clock_sec, posedge stopwatch_reset)
begin
    if(stopwatch_reset)                                     // cheack for active high reset
        begin                                              // reset the stopwatch
        stopwatch_seconds=0;
        stopwatch_minutes=0;
        stopwatch_hours=0;
        end
    else if(stopwatch_on)                                   // begenning of each stopwatch second
        begin
        stopwatch_seconds=stopwatch_seconds+1;                // increment stopwatch  seconds
        if(stopwatch_seconds==60)                             // cheack for maximum value of stopwatch seconds
            begin
            stopwatch_seconds=0;                              // reset seconds
            stopwatch_minutes=stopwatch_minutes+1;           // increment stopwatch minutes
            if(stopwatch_minutes==60)                        // cheack for maximum value of stopwatch minutes
                begin
                stopwatch_minutes=0;                         // reset stopwatch minutes
                stopwatch_hours = stopwatch_hours+1;         // increment stopwatch hours
                if(stopwatch_hours==24)                      // cheack for maximum stopwatch hours
                    begin
                    stopwatch_hours=0;                       // reset stopwatch hours
                    end
                end
            end
        end
end

//assign alarm_ringing=((hours^alarm_hour)||(minutes^alarm_minute)||(am_pm^alarm_am_pm))?1'b0:1'b1;
                
        
   

             
    




endmodule
