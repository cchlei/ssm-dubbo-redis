package com.demo.common;

import java.text.ParseException;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtil extends DateUtils {

	public static final String FORAMT14 = "yyyyMMddHHmmss";
	public static final String FORAMT8 = "yyyyMMdd";
	public static final String FORAMT = "yyyy-MM-dd HH:mm:ss";
	
	public static int getWeek(Date date){
		
		Calendar c = Calendar.getInstance();
		  c.setTimeInMillis(date.getTime());
		  int dayForWeek = 0;
		  if(c.get(Calendar.DAY_OF_WEEK) == 1){
		   dayForWeek = 7;
		  }else{
		   dayForWeek = c.get(Calendar.DAY_OF_WEEK) - 1;
		  }
		  return dayForWeek;
	}
	
	public static int getAmpm(Date date){
		
		Calendar c = Calendar.getInstance();
		  c.setTimeInMillis(date.getTime());
		  return 1+c.get(Calendar.AM_PM);
		
	}
	/**
	 * 一天内 一个日期 +时间
	 * @param date yyyy-MM-dd
	 * @param time hh:mm:ss
	 * @return
	 */
	public static Date parseDateAndTime(Date date , Date time){
		String d = formatDate(date, "yyyy-MM-dd");
		String t = formatDate(time, " hh:mm:ss");
		return parseDateTime(d + t, "yyyy-MM-dd hh:mm:ss");
	}
	
	public static void main(String[] args) {
		System.out.println(strToDateLong("19931128100523"));
		System.out.println(toString14(strToDateLong("19931128100523")));
	}
	/**
	 * 
	 * @param date
	 * @return yyyyMMddHHmmss
	 */
	public static String toString12(Date date){
		return formatDate(date, FORAMT14);
	}
	/**
	 * 
	 * @param date
	 * @return yyyyMMdd
	 */
	public static String toString8(Date date){
		return formatDate(date, FORAMT8);
	}
	
	public static Date parse8(String source){
		return parse(source, FORAMT8);
	}
	
	public static Calendar toCalendar(String dateString, String formatPattern){
		return toCalendar(parseDateTime(dateString, formatPattern));
	}
	
	/*
	 * 日期转换字符串
	 */
	public static Date StringCovertDate(String dateStr)
	{
		
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");//转换格式
		try {
			return sdf.parse(dateStr);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();//打印	
		}
		return null;
	}
	/*
	 * 日期转换字符串
	 */
	public static Date StringCovertDate1(String dateStr)
	{
		
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//转换格式
		try {
			return sdf.parse(dateStr);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();//打印	
		}
		return null;
	}
	
	public static Date parse(String source, String...parsePatterns) {
		try {
			return parseDate(source, parsePatterns);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	  // yyyymmdd ---- yyyy-mm-dd
	public static String dateSub(String dateStr) {
		String s2 = "-";
		String s3 = dateStr.substring(0, 4) + s2 + dateStr.substring(4, dateStr.length());// 2016-0918
		String s4 = s3.substring(0, 7) + s2 + s3.substring(7, s3.length());// 2016-09-18
		return s4;
	}
	/**
	 * 
	 * @param date
	 *   Date 转   （String）yyyy-MM-dd HH:mm:ss
	 * @return yyyy-MM-dd HH:mm:ss
	 */
	public static String toString14(Date date){
		return formatDate(date, FORAMT);
	}
	/**
	   * 将长时间格式字符串转换为时间 yyyy-MM-dd HH:mm:ss
	   * (String)yyyyMMddHHmmss  转  Date
	   * @param strDate
	   * @return
	   */
	public static Date strToDateLong(String strDate) {
	   SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
	   ParsePosition pos = new ParsePosition(0);
	   Date strtodate = formatter.parse(strDate, pos);
	   return strtodate;
	}
	/**
	 * yyyyMMddHHmmss  转 yyyy-MM-dd HH:mm:ss
	 */
	public static String str2str(String strDate) {
		
		return toString14(strToDateLong(strDate));
		}
}
