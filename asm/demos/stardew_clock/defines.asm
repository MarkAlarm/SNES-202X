; tick (2 bytes)
; check if equal to the tick rate. if not, increment. otherwise, reset and increment the clock time
!stardew_clock_tick = $0120

; tick rate (2 bytes)
; how many frames must pass before the time increments
; 0 = 10 IGT minutes per frame
; $FF = 10 IGT minutes per ~4.25 seconds
; $1A4 = 10 IGT minutes per 7 seconds (identical to original)
; $8CA0 = 10 IGT minutes per 10 minutes (1:1 time)
!stardew_clock_tick_rate = $0122

; time (1 byte)
; 12:00 = 0, 12:10 = 1, ..., 11:50 = $47
!stardew_clock_time = $0124

; am/pm (1 byte)
; 0 = am, 1 = pm
!stardew_clock_am_pm = $0125

; day of the week (1 byte)
; sunday = 0, monday = 1, ..., saturday = 6
!stardew_clock_day_in_week = $0126

; season (1 byte)
; spring = 0, summer = 1, autumn = 2, winter = 3
!stardew_clock_season = $0127

; day of the season (1 byte)
; 0 = unused, day 1 = 1, day 2 = 2, ..., day 28 = 28
!stardew_clock_day_in_season = $0128

; total days (2 bytes)
; incremental (starts at day 1, day 0 is unused, stops counting at 9999 (will disp a + if greater and never actually increment)
!stardew_clock_days = $0129

; year (1 byte)
; incremental (starts at year 1, year 0 is unused, stops counting at 99 (will disp a + if greater and never actually increment)
!stardew_clock_years = $012B

; weather (1 byte)
; sunny = 0, cloudy = 1, foggy = 2, windy = 3, raining = 4, snowing = 5, storming = 6, diamond dust = 7
!stardew_clock_weather = $012C
