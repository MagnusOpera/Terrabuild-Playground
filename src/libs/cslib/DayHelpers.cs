namespace cslib;
using System;

public static class DateTimeExtensions {
    public static string LocalizedDayName(this DateTime @this) {
        return @this.ToString("dddd");
    }
}
