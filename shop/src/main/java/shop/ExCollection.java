package shop;
import java.util.*;

public class ExCollection {

	public static void main(String[] args) {
		//1.배열
		String [] arr = new String[3];
		arr[0] = "루피"; //a)배열에 데이터를 할당 시 인덱스 넘버를 반드시 알아야 한다.
		arr[1] = "조로"; //b)인뎃스는 가지고는 데어터 추측이 힘들다 / d 인뎃스 범위는 초과할 수 없
		arr[2] = "나미"; //c)중복된 데이터값을 피할 수없다.
		
		//2.컬렉션 프레임워크(자바 기본API제공)
		ArrayList<String>  list = new ArrayList<String>(2);
		
		list.add("루피"); //a해결
		list.add("조로");
		list.add("나미"); //d 해결
		list.add("루피");
		for(String s : list) {
			System.out.println(s);
		}
		System.out.println("=================");
		HashSet<String> set = new HashSet<String>();
		set.add("루피");
		set.add("조로");
		set.add("루피");  //중복된 데이터를 허용아함
		for(String s:set) {
			System.out.println(s); //인덱스 존재안함
		}
		System.out.println("=================");
		HashMap<String, String> map = new HashMap <String, String>();
		map.put("선장", "루피");
		map.put("부선장", "조로");
		map.put("항해사", "나미");
		System.out.println(map.get("부선장")); //b 인덱스 대신에 문자열도 가능
		
		//List+Map 같이 사용
		
		//맵의 배열
		ArrayList<HashMap<String,String>> mapList = new ArrayList<HashMap<String,String>>();
		HashMap<String,String> m1 = new HashMap<String,String>();
		m1.put("name", "루피");
		m1.put("pirateName", "밀짚모자해적단");
		HashMap<String,String> m2 = new HashMap<String,String>();
		m2.put("name", "샹크스");
		m2.put("pirateName", "빨간머리해적단");
		
		mapList.add(m1);
		mapList.add(m2);
		
		for(HashMap<String,String> m :mapList) {
			System.out.printf("%s,%s\n", m.get("name"), m.get("pirateName"));
		}
		
		//Reusltset 한 행을 저장하는 것에 가장 좋은게 -> map
	
		//ResultSet --> ArrayList 바꿈 => 왜? 
	}

}
