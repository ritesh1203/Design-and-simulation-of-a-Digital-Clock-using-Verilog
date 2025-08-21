`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.08.2023 19:13:09
// Design Name: 
// Module Name: Digital_clock_tb
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


module Digital_clock_tb();
reg clock_sec; //clock with frequency of 1Hz and time period 1sec.
reg reset;     // Active high asynchronous reset
reg set_time;
reg set_am_pm;  // to set am or pm. here set_am_pm =1 for pm and set_am_pm=0 for am. 
reg alarm_am_pm;
reg stopwatch_on;
reg stopwatch_reset;
reg [3:0] set_hour;
reg [5:0] set_minute;
reg [3:0] alarm_hour;
reg [5:0] alarm_minute;

wire am_pm;
wire alarm_ringing;
wire [3:0] hours;
wire [5:0] minutes;
wire [5:0] seconds;
wire [4:0] stopwatch_hours;
wire [5:0] stopwatch_minutes;
wire [5:0] stopwatch_seconds;

Digital_clock dut( .clock_sec(clock_sec),.reset(reset),.set_time(set_time),.set_hour(set_hour),.set_minute(set_minute),.set_am_pm(set_am_pm),.alarm_hour(alarm_hour),
.alarm_minute(alarm_minute),.alarm_am_pm(alarm_am_pm),.stopwatch_on(stopwatch_on),.stopwatch_reset(stopwatch_reset),.seconds(seconds),.minutes(minutes),.hours(hours),
.am_pm(am_pm),.stopwatch_hours(stopwatch_hours),.stopwatch_minutes(stopwatch_minutes),.stopwatch_seconds(stopwatch_seconds),.alarm_ringing(alarm_ringing));

initial
clock_sec=0;
always
begin
 #1 clock_sec= ~clock_sec;
 end
 
 initial
 begin
 $monitor($time,"clock_sec=%b reset=%b set_time=%b seconds=%d minutes=%d hours=%d",clock_sec,reset,set_time,seconds,minutes,hours); 
 reset=1'b1;
 #3 
      reset=1'b0;
 #9 
      set_time=1'b1;
      set_am_pm=1'b1;
      set_hour=2;
      set_minute=45;
      
 #3
      set_time=1'b0;
      
 #2   alarm_hour=2;
      alarm_minute=50;
      alarm_am_pm=1'b1;
 #5
      stopwatch_reset=1'b1;
#3  
      stopwatch_reset=1'b0;
      stopwatch_on=1'b1;
      
end
 
 

endmodule
