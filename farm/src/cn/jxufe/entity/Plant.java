package cn.jxufe.entity;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import cn.jxufe.bean.EntityID;

@Entity
@Table(name = "t_plant")
public class Plant extends EntityID{

	private static final long serialVersionUID = 1L;
	
	@ManyToOne
	@JoinColumn(name = "userId")
	private User user;
	@ManyToOne
	@JoinColumn(name = "phaseId")
	private Phase phase;
	private int landIndex;/*landIndex表示第几块土地*/
	/* *
	  *  进入此阶段的时间，单位为second，
	  *  如果time>=phase.growthTime一致的话， 说明已经生长完成可以进入下一阶段;
	  *  每两秒更新一次，所以每次都是time += 2；
	 * */
	private int time;
	/*表示用户用于种植作物的土地*/
	@ManyToOne
	@JoinColumn(name = "landId")
	private Land land;
	@Transient
	private Seed seed = new Seed();// 临时字段
	private int nowSeason = 0;//	处在第i个季度
	private boolean worm = false;//	是否生虫，默认值为不生虫
	private int reduce = 0;//	减产个数
	
	
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Phase getPhase() {
		return phase;
	}
	public void setPhase(Phase phase) {
		this.phase = phase;
	}
	public int getLandIndex() {
		return landIndex;
	}
	public void setLandIndex(int landIndex) {
		this.landIndex = landIndex;
	}
	public int getTime() {
		return time;
	}
	public void setTime(int time) {
		this.time = time;
	}
	public Land getLand() {
		return land;
	}
	public void setLand(Land land) {
		this.land = land;
	}
	public long getUserId() {
		return user.getId();
	}
	public long getLandId() {
		return land.getId();
	}
	public long getSeedId() {
		return seed.getId();
	}
	public Seed getPhaseSeed() {
		return phase.getSeed();
	}
	public Seed getSeed() {
		return seed;
	}
	public void setSeed(Seed seed) {
		this.seed = seed;
	}
	public int getPhaseNum() {
		return phase.getPhase();
	}
	public long getPhaseSeedId() {
		return phase.getSeedId();
	}
	public int getNowSeason() {
		return nowSeason;
	}
	public void setNowSeason(int nowSeason) {
		this.nowSeason = nowSeason;
	}
	public double getWormChance() {
		return phase.getChance();
	}
	public boolean isWorm() {
		return worm;
	}
	public void setWorm(boolean worm) {
		this.worm = worm;
	}
	
	public int getReduce() {
		return reduce;
	}
	public void setReduce(int reduce) {
		this.reduce = reduce;
	}
	public void clone(Plant plant) {
		this.land = plant.land;
		this.landIndex = plant.landIndex;
		this.phase = plant.phase;
		this.time = plant.time;
		this.user = plant.user;
		this.nowSeason = plant.nowSeason;
		this.seed = plant.seed;
		this.worm = plant.worm;
		this.reduce = plant.reduce;
	}
}
