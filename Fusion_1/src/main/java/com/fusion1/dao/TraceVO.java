package com.fusion1.dao;

public class TraceVO {

	private int trace_no;
	private String trace_code;
	private String trace_user;
	private String trace_date;
	private int writeCount;
	private int editCount;
	private int deleteCount;
	private int replyCount;
	private int signoutCount;

	public int getTrace_no() {
		return trace_no;
	}

	public void setTrace_no(int trace_no) {
		this.trace_no = trace_no;
	}

	public String getTrace_code() {
		return trace_code;
	}

	public void setTrace_code(String trace_code) {
		this.trace_code = trace_code;
	}

	public String getTrace_user() {
		return trace_user;
	}

	public void setTrace_user(String trace_user) {
		this.trace_user = trace_user;
	}

	public String getTrace_date() {
		return trace_date;
	}

	public void setTrace_date(String trace_date) {
		this.trace_date = trace_date;
	}

	public int getWriteCount() {
		return writeCount;
	}

	public void setWriteCount(int writeCount) {
		this.writeCount = writeCount;
	}

	public int getEditCount() {
		return editCount;
	}

	public void setEditCount(int editCount) {
		this.editCount = editCount;
	}

	public int getDeleteCount() {
		return deleteCount;
	}

	public void setDeleteCount(int deleteCount) {
		this.deleteCount = deleteCount;
	}

	public int getReplyCount() {
		return replyCount;
	}

	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}

	public int getSignoutCount() {
		return signoutCount;
	}

	public void setSignoutCount(int signoutCount) {
		this.signoutCount = signoutCount;
	}

	@Override
	public String toString() {
		return "TraceVO [trace_no=" + trace_no + ", trace_code=" + trace_code + ", trace_user=" + trace_user
				+ ", trace_date=" + trace_date + ", writeCount=" + writeCount + ", editCount=" + editCount
				+ ", deleteCount=" + deleteCount + ", replyCount=" + replyCount + ", signoutCount=" + signoutCount
				+ "]";
	}
	
	
}
