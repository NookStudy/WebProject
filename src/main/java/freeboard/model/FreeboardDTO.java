package freeboard.model;

public class FreeboardDTO {
	private String freeno;
	private String id;
	private String nickname;
	private String title;
	private String content;
	private java.sql.Date postdate;
	private String ofile;
	private String nfile;
	private String downcount;
	private String visitcount;
	private String cate;
	private String heart;
	private String replycount;
	
	public String getReplycount() {
		return replycount;
	}
	public void setReplycount(String replycount) {
		this.replycount = replycount;
	}
	public String getHeart() {
		return heart;
	}
	public void setHeart(String heart) {
		this.heart = heart;
	}
	public String getFreeno() {
		return freeno;
	}
	public void setFreeno(String freeno) {
		this.freeno = freeno;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public java.sql.Date getPostdate() {
		return postdate;
	}
	public void setPostdate(java.sql.Date postdate) {
		this.postdate = postdate;
	}
	public String getOfile() {
		return ofile;
	}
	public void setOfile(String ofile) {
		this.ofile = ofile;
	}
	public String getNfile() {
		return nfile;
	}
	public void setNfile(String nfile) {
		this.nfile = nfile;
	}
	public String getDowncount() {
		return downcount;
	}
	public void setDowncount(String downcount) {
		this.downcount = downcount;
	}
	public String getVisitcount() {
		return visitcount;
	}
	public void setVisitcount(String visitcount) {
		this.visitcount = visitcount;
	}
	public String getCate() {
		return cate;
	}
	public void setCate(String cate) {
		this.cate = cate;
	}
	@Override
	public String toString() {
		return "FreeboardDTO [freeno=" + freeno + ", id=" + id + ", nickname=" + nickname + ", title=" + title
				+ ", content=" + content + ", postdate=" + postdate + ", ofile=" + ofile + ", nfile=" + nfile
				+ ", downcount=" + downcount + ", visitcount=" + visitcount + ", cate=" + cate + "]";
	}
	
}
