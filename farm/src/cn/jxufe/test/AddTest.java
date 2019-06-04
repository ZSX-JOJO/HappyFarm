package cn.jxufe.test;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import org.junit.Test;

import cn.jxufe.entity.Land;
import net.sf.json.JSONArray;

public class AddTest {

	@Test
	public void addUser() {
		List<Land> list = init();
		writeFile(JSONArray.fromObject(list).toString());
	}
	
	public List<Land> init() {
		ArrayList<Land> result = new ArrayList<>();
		Land land1 = new Land();
		land1.setId(1);
		land1.setName("黄土地");
		Land land2 = new Land();
		land2.setId(2);
		land2.setName("红土地");
		result.add(land1);
		result.add(land2);
		return result;
	}
	
	public void writeFile(String str) {
		File file = new File("E:\\jsontest.txt");
		if(!file.exists()) {
			try {
				file.createNewFile();
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
			
		try {
			FileWriter fw;
			fw = new FileWriter(file);
			BufferedWriter  bw=new BufferedWriter(fw);
	        bw.write(str+"\t\n");
	        bw.close();
	        fw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
