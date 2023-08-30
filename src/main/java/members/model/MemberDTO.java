package members.model;

public class MemberDTO {
	private String userno;
	private String id;
	private String pass;
	private String name;
	private String nickname;
	private String email;
	private String adress1;
	private String adress2;
	private String gender;
	private String birth;
	private java.sql.Date regidate;
	private String phonenumber;
	private String postcode;
	
	public String getUserno() {
		return userno;
	}
	public void setUserno(String userno) {
		this.userno = userno;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAdress1() {
		return adress1;
	}
	public void setAdress1(String adress1) {
		this.adress1 = adress1;
	}
	public String getAdress2() {
		return adress2;
	}
	public void setAdress2(String adress2) {
		this.adress2 = adress2;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public java.sql.Date getRegidate() {
		return regidate;
	}
	public void setRegidate(java.sql.Date regidate) {
		this.regidate = regidate;
	}
	public String getPhonenumber() {
		return phonenumber;
	}
	public void setPhonenumber(String phonenumber) {
		this.phonenumber = phonenumber;
	}
	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	@Override
	public String toString() {
		return "MemberDTO [userno=" + userno + ", id=" + id + ", pass=" + pass + ", name=" + name + ", nickname="
				+ nickname + ", email=" + email + ", adress1=" + adress1 + ", adress2=" + adress2 + ", gender=" + gender
				+ ", birth=" + birth + ", regidate=" + regidate + ", phonenumber=" + phonenumber + ", getUserno()="
				+ getUserno() + ", getId()=" + getId() + ", getPass()=" + getPass() + ", getName()=" + getName()
				+ ", getNickname()=" + getNickname() + ", getEmail()=" + getEmail() + ", getAdress1()=" + getAdress1()
				+ ", getAdress2()=" + getAdress2() + ", getGender()=" + getGender() + ", getBirth()=" + getBirth()
				+ ", getRegidate()=" + getRegidate() + ", getPhonenumber()=" + getPhonenumber() + ", getClass()="
				+ getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString() + "]";
	}

	
	
}
