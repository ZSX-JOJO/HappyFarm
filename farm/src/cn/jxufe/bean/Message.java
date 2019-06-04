package cn.jxufe.bean;

import net.sf.json.JSONObject;

public class Message {
	private int code;
	private String msg;
	private JSONObject data;
	
	public Message() {};
	
	public Message(int code,String msg) {
		this.code = code;
		this.msg = msg;
	}
	
	public Message(int code,String msg,JSONObject data) {
		this.code = code;
		this.msg = msg;
		this.data = data;
	}
	
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public JSONObject getData() {
		return data;
	}
	public void setData(JSONObject data) {
		this.data = data;
	}
}
