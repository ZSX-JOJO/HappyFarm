package cn.jxufe.entity;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import cn.jxufe.bean.EntityID;

@Entity
@Table(name = "t_repository")
public class Repository extends EntityID{

	private static final long serialVersionUID = 1L;

	@ManyToOne
    @JoinColumn(name="userId")
	private User user;
	@ManyToOne
    @JoinColumn(name="seedId")
	private Seed seed;
	private int num;
	
	
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Seed getSeed() {
		return seed;
	}
	public void setSeed(Seed seed) {
		this.seed = seed;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	
}
