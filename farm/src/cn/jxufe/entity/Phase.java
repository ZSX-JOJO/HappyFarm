package cn.jxufe.entity;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;
import cn.jxufe.bean.EntityID;

@Entity
@Table(name = "t_phase")
public class Phase extends EntityID{

	private static final long serialVersionUID = 1L;
	
	private long seedId;
	@Transient
	private Seed seed;
	private int phase;
	private String title;
	private int growthTime;
	private double chance;
	private double width;
	private double height;
	private double offsetX;
	private double offsetY;
	private long statusId;
	
	public long getSeedId() {
		return seedId;
	}
	public void setSeedId(long seedId) {
		this.seedId = seedId;
	}
	public int getPhase() {
		return phase;
	}
	public void setPhase(int phase) {
		this.phase = phase;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getGrowthTime() {
		return growthTime;
	}
	public void setGrowthTime(int growthTime) {
		this.growthTime = growthTime;
	}
	public double getChance() {
		return chance;
	}
	public void setChance(double chance) {
		this.chance = chance;
	}
	public double getWidth() {
		return width;
	}
	public void setWidth(double width) {
		this.width = width;
	}
	public double getHeight() {
		return height;
	}
	public void setHeight(double height) {
		this.height = height;
	}
	public double getOffsetX() {
		return offsetX;
	}
	public void setOffsetX(double offsetX) {
		this.offsetX = offsetX;
	}
	public double getOffsetY() {
		return offsetY;
	}
	public void setOffsetY(double offsetY) {
		this.offsetY = offsetY;
	}
	public long getStatusId() {
		return statusId;
	}
	public void setStatusId(long statusId) {
		this.statusId = statusId;
	}
	public Seed getSeed() {
		return seed;
	}
	public void setSeed(Seed seed) {
		this.seed = seed;
	}
	
	public void clone(Phase phase) {
		this.chance = phase.chance;
		this.growthTime = phase.growthTime;
		this.height = phase.height;
		this.offsetX = phase.offsetX;
		this.offsetY = phase.offsetY;
		this.phase = phase.phase;
		this.seed = phase.seed;
		this.seedId = phase.seedId;
		this.statusId = phase.statusId;
		this.title = phase.title;
		this.width = phase.width;
	}
}
