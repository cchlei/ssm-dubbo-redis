/**
 * Copyright (c) 2014 ShanghaiMed iKang,Inc. All rights reserved.
 */
package com.demo.common;

import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang.time.DateFormatUtils;

/**
 * 日期工具类, 继承{@link org.apache.commons.lang.time.DateUtils}.
 * 
 * @author <a href="mailto:jason.wu@ikang.com">Wu Jun</a>
 * @version 1.0, 10/13/2014
 */
public abstract class DateUtils extends org.apache.commons.lang.time.DateUtils {

	private static String[] parsePatterns = { "yyyy-MM-dd", "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd HH:mm",
			"HH:mm", "yyyy/MM/dd", "yyyy/MM/dd HH:mm:ss", "yyyy/MM/dd HH:mm", "HH:mm:ss", "HH:mm" };

	/**
	 * 日期格式.
	 */
	public enum Format {

		/** The format used is <tt>yyyy-MM-dd HH:mm:ss</tt>. */
		DATETIME("yyyy-MM-dd HH:mm:ss"),

		/** The format used is <tt>yyyy-MM-dd HH:mm:ssZZ</tt>. */
		DATETIME_TIME_ZONE("yyyy-MM-dd HH:mm:ssZZ"),

		/** The format used is <tt>yyyy-MM-dd</tt>. */
		DATE("yyyy-MM-dd"),

		/** The format used is <tt>HH:mm:ss</tt>. */
		TIME("HH:mm:ss"),

		/** The format used is <tt>HH:mm:ssZZ</tt>. */
		TIME_NO_T_TIME_ZONE("HH:mm:ssZZ"),

		/** The format used is <tt>yyyy</tt>. */
		YEAR("yyyy"),

		/** The format used is <tt>yy</tt>. */
		YEAR_TWO("yyyy"),

		/** The format used is <tt>MM</tt>. */
		MONTH("MM"),

		/** The format used is <tt>M</tt>. */
		MONTH_ONE("M"),

		/** The format used is <tt>yyyy-MM</tt>. */
		YEAR_MONTH("yyyy-MM"),

		/** The format used is <tt>yyyy-MM</tt>. */
		HOURE_MINUTE("HH:mm"), ;

		private String value;

		private Format(String value) {
			this.value = value;
		}

		@Override
		public String toString() {
			return this.value;
		}
	}

	/**
	 * 格式化日期为{@link DateFormat.DATETIME}格式.
	 * 
	 * @param date
	 * @param pattern
	 * @return
	 */
	public static String formatDatetime(Date date) {
		return formatDate(date, Format.DATETIME.toString());
	}

	/**
	 * 格式化日期为{@link DateFormat.DATE}格式.
	 * 
	 * @param date
	 * @param pattern
	 * @return
	 */
	public static String formatDate(Date date) {
		return formatDate(date, Format.DATE.toString());
	}

	/**
	 * 格式化日期为{@link DateFormat.TIME}格式.
	 * 
	 * @param date
	 * @param pattern
	 * @return
	 */
	public static String formatTime(Date date) {
		return formatDate(date, Format.TIME.toString());
	}

	/**
	 * 按指定的格式格式化日期, 默认格式: {@link DateFormat.DATE}.
	 * 
	 * @param date
	 * @param pattern
	 * @return string
	 */
	public static String formatDate(Date date, String pattern) {
		if (date == null) {
			return null;
		}
		String formatDate = null;
		if (pattern == null) {
			pattern = Format.DATE.toString();
		}
		formatDate = DateFormatUtils.format(date, pattern);
		return formatDate;
	}

	/**
	 * 日期型字符串转化为日期, 默认格式: {@link DateFormat.DATE}.
	 * 
	 * @param str
	 * @param pattern
	 * @return date
	 */
	public static Date parseDateTime(String str, String pattern) {
		if (str == null) {
			return null;
		}
		if (pattern == null || pattern.trim() == "") {
			pattern = Format.DATE.toString();
		}
		try {
			return parseDate(str.toString(), new String[] { pattern });
		} catch (ParseException e) {
			return null;
		}
	}

	/**
	 * 字符日期转换成格式为：{@link DateFormat.DATETIME}的日期.
	 * 
	 * @param str
	 * @return data
	 */
	public static Date parseDatetime(String str) {
		return parseDateTime(str, Format.DATETIME.toString());
	}

	/**
	 * 日期型字符串转化为日期 格式 { "yyyy-MM-dd", "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd HH:mm", "yyyy/MM/dd",
	 * "yyyy/MM/dd HH:mm:ss", "yyyy/MM/dd HH:mm" }
	 * 
	 * @param str
	 * @return
	 */
	public static Date parseDate(String str) {
		if (str == null) {
			return null;
		}
		try {
			return parseDate(str, parsePatterns);
		} catch (ParseException e) {
			return null;
		}
	}

	/**
	 * 获取当前日期是星期几<br>
	 * 
	 * @param date
	 * @return 当前日期是星期几
	 */
	public static String getWeekOfDate(Date date) {
		String[] weekDays = { "周日", "周一", "周二", "周三", "周四", "周五", "周六" };
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		int week = cal.get(Calendar.DAY_OF_WEEK) - 1;
		if (week < 0) week = 0;
		return weekDays[week];
	}
}
