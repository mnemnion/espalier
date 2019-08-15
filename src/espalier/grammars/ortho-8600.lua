

























































--local Node    =  require "espalier/node"
--local Grammar =  require "espalier/grammar"
local require = assert(require)
local L       =  require "espalier/elpatt"
local Node    =  require "espalier/node"
local Grammar =  require "espalier/grammar"

local P, R, E, V, S, D   =  L.P, L.R, L.E, L.V, L.S, L.D






local Day = Node : inherit ()
Day.id = "day"
local Month = Node : inherit ()
Month.id = "month"
local Year = Node : inherit ()
Year.id =  "year"

local date_metas = { oneThru30 = Day,
                     oneThru29 = Day,
                     m31       = Month,
                     m30       = Month,
                     mFeb      = Month }

local function _post(date)
   date.id = "DATE"
   error "post function callec"
   for day in date:select "day" do
      if day[1].id == "day" then
        day[1] = nil
      end
   end
   return date
end





local function _date_fn(_ENV)

   START "date"

   SUPPRESS ("positiveYear", "negativeYear"
            , "yearMonth", "yearMonthDay", "monthDay"
             -- , "oneThru12", "oneThru29",
             -- , "oneThru30", "oneThru31"
             )

   date         = V"yearMonthDay"
                + V"yearMonth"
                + V"year"

   year         = V"positiveYear" + V"negativeYear" + P"0000"

   positiveYear = R"19"  * R"09" * R"09" * R"09"
                + P"0"   * R"19" * R"09"
                + P"00"  * R"19" * R"09"
                + P"000" * R"19"

   negativeYear =  P"-" * V"positiveYear"

   monthDay     = V"m31"  * P"-" * V"day"
                + V"m30"  * P"-" * (-V"longMonth" * V"day")
                + V"mFeb" * P"-" * (-V"threeDecan" * V"day")

   m31          = (P"01" + P"03" + P"05" + P"07" + "08" + "10" + "12")

   m30          = (P"04" + P"06" + P"09" + P"11")

   mFeb         = P"02"

   yearMonth    = V"year" * P"-" * V"month"

   yearMonthDay = V"year" * P"-" *  V"monthDay"

   month        = V"m31" + V"m30" + V"mFeb"

   day          = (P"0" * R"19")
                + (P"1" + P"2") * R"09"
                + P"30"
                + P"31"

   oneThru12    = (P"0" *  R"19") + P"10" + P"11" + P"12"

   oneThru29    = (P"0" * R"19")
                + (P"1" + P"2") * R"09"

   oneThru30    = P"30" + V"oneThru29"

   oneThru31    = V"longMonth" + V"oneThru30"

   longMonth    = P"31"

   threeDecan   = V"longMonth" + P"30"

   -- (* 4. Date and Time Extensions *)
end



   return Grammar(_date_fn, date_metas, nil, _post)
