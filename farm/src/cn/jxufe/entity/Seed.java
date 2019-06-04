package cn.jxufe.entity;

import javax.persistence.Entity;
import javax.persistence.Table;

import cn.jxufe.bean.EntityID;

@Entity
@Table(name = "t_seed")
public class Seed extends EntityID {

	private static final long serialVersionUID = 1L;
	
	private long seedId;
	private String name;
	private int season;
	private long level;
	
	private long categoryId;
	private int experience;
	private int harvestTime;
	private int harvestNum;
	private int seedPurPrice;
	private int fruitPrice;
	
	private long landId;
	private int integral;
	private String tip;

	public long getSeedId() {
		return seedId;
	}

	public void setSeedId(long seedId) {
		this.seedId = seedId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getSeason() {
		return season;
	}

	public void setSeason(int season) {
		this.season = season;
	}

	public long getLevel() {
		return level;
	}

	public void setLevel(long level) {
		this.level = level;
	}

	public int getExperience() {
		return experience;
	}

	public void setExperience(int experience) {
		this.experience = experience;
	}

	public int getHarvestTime() {
		return harvestTime;
	}

	public void setHarvestTime(int harvestTime) {
		this.harvestTime = harvestTime;
	}

	public int getHarvestNum() {
		return harvestNum;
	}

	public void setHarvestNum(int harvestNum) {
		this.harvestNum = harvestNum;
	}

	public int getSeedPurPrice() {
		return seedPurPrice;
	}

	public void setSeedPurPrice(int seedPurPrice) {
		this.seedPurPrice = seedPurPrice;
	}

	public int getFruitPrice() {
		return fruitPrice;
	}

	public void setFruitPrice(int fruitPrice) {
		this.fruitPrice = fruitPrice;
	}

	public int getIntegral() {
		return integral;
	}

	public void setIntegral(int integral) {
		this.integral = integral;
	}

	public String getTip() {
		return tip;
	}

	public void setTip(String tip) {
		this.tip = tip;
	}

	public long getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(long categoryId) {
		this.categoryId = categoryId;
	}

	public long getLandId() {
		return landId;
	}

	public void setLandId(long landId) {
		this.landId = landId;
	}
	
	public void clone(Seed seed) {
		this.categoryId = seed.categoryId;
		this.experience = seed.experience;
		this.fruitPrice = seed.fruitPrice;
		this.harvestNum = seed.harvestNum;
		this.harvestTime = seed.harvestTime;
		this.integral = seed.integral;
		this.landId = seed.landId;
		this.level = seed.level;
		this.name = seed.name;
		this.season = seed.season;
		this.seedId = seed.seedId;
		this.seedPurPrice = seed.seedPurPrice;
		this.tip = seed.tip;
	}
}
