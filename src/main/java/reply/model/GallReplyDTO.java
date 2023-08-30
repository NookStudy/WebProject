package reply.model;


public class GallReplyDTO {
	private int replyno;
	private String id;
	private int gallno;
	private String replycontent;
	private java.sql.Date replyDate;
	private int replyAvailable;
	
	public int getReplyno() {
		return replyno;
	}
	public void setReplyno(int replyno) {
		this.replyno = replyno;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getGallno() {
		return gallno;
	}
	public void setGallno(int gallno) {
		this.gallno = gallno;
	}
	public String getReplycontent() {
		return replycontent;
	}
	public void setReplycontent(String replycontent) {
		this.replycontent = replycontent;
	}
	public java.sql.Date getReplyDate() {
		return replyDate;
	}
	public void setReplyDate(java.sql.Date replyDate) {
		this.replyDate = replyDate;
	}
	public int getReplyAvailable() {
		return replyAvailable;
	}
	public void setReplyAvailable(int replyAvailable) {
		this.replyAvailable = replyAvailable;
	}
	@Override
	public String toString() {
		return "GallReplyDTO [replyno=" + replyno + ", id=" + id + ", gallno=" + gallno + ", replycontent="
				+ replycontent + ", replyDate=" + replyDate + ", replyAvailable=" + replyAvailable + "]";
	}
	
	
	
	
}
