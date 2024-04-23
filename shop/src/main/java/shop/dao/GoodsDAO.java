package shop.dao;

import java.sql.*;
import java.util.*;



public class GoodsDAO {
	//페이징 -> 카테고리별 lastpage구하기
	public static int page (String category) throws Exception{
		int lastPage = 0;
		int rowPerPage = 15;
		Connection con = DBHelper.getConnection();
		String pageSql = null;
		//category가 null일경우 제거
		PreparedStatement pageStmt = null;
		ResultSet pageRs = null;
		
		//전체 상품갯수 // 카테고리별 상품갯수 분기하기
		if(category == ""){
			pageSql = "select count(*) from goods";
			pageStmt = con.prepareStatement(pageSql);
		}else{
			pageSql = "select count(*) from goods where category =?";
			pageStmt = con.prepareStatement(pageSql);
			pageStmt.setString(1,category);
		}
		pageRs = pageStmt.executeQuery();
		
		int totalRow = 0;
		if(pageRs.next()){
			totalRow = pageRs.getInt("count(*)");
		}
		lastPage = totalRow/rowPerPage;
		if(totalRow%rowPerPage != 0){
			lastPage = lastPage +1;
		}
		con.close();
		return lastPage;
	}
	public static ArrayList<HashMap<String, Object>> selectCategoryList () throws Exception{
		//굿즈 카테고리 메뉴 출력
		ArrayList<HashMap<String, Object>> categoryList =
				new ArrayList<HashMap<String, Object>>();
		//디비연결
		Connection con = DBHelper.getConnection();
		String sql = "select category, count(*) cnt from goods group by category order by category asc";
		PreparedStatement stmt = con.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("category", rs.getString("category"));
			m.put("cnt", rs.getInt("cnt"));
			categoryList.add(m);
		}
		con.close();
		return categoryList;
	}
	public static ArrayList<HashMap<String, Object>> selectGoodsList (String category,int startRow, int rowPerPage) throws Exception{
		//굿즈 리스트 출력
		ArrayList<HashMap<String, Object>> goodsList =
				new ArrayList<HashMap<String, Object>>();
		//디비연결
		Connection con = DBHelper.getConnection();
		//sql 분기
		String sql = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		if(category == "") {
			sql = "select * from goods limit ?,?";
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, startRow);
			stmt.setInt(2, rowPerPage);
		}else {
			sql = "select * from goods where category=? limit ?,?";
			stmt = con.prepareStatement(sql);
			stmt.setString(1, category);
			stmt.setInt(2, startRow);
			stmt.setInt(3, rowPerPage);
			
		}
		
		rs = stmt.executeQuery();
		
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("goodsNo", rs.getInt("goods_no"));
			m.put("goodsTitle", rs.getString("goods_title"));
			m.put("fileName", rs.getString("filename"));
			m.put("goodsPrice", rs.getInt("goods_price"));
			goodsList.add(m);
		}
		con.close();
		return goodsList;
	}
	//update 쿼리날리기
	public static int updateGoodsList (int goodsNo,String empId,String category,int goodsPrice,int goodsAmount,String goodsTitle,String goodsContent,String filename) throws Exception{
		Connection con = DBHelper.getConnection();
		
		String sql = "update goods set category=?,emp_id=?,goods_price=?,goods_amount=?,goods_title=?,filename=?, goods_content=?,update_date=now() where goods_no=?";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1,category);
		stmt.setString(2,empId);
		stmt.setInt(3,goodsPrice);
		stmt.setInt(4,goodsAmount);
		stmt.setString(5,goodsTitle);
		stmt.setString(6,filename);
		stmt.setString(7,goodsContent);
		stmt.setInt(8,goodsNo);
		System.out.println(stmt +"stmt 확인 --> updateGoodsList DAO");
		
		int row = stmt.executeUpdate();
		
		con.close();
		return row;
	}
	public static ArrayList<HashMap<String,Object>> updateGoodsForm (int goodsNo) throws Exception {
		ArrayList<HashMap<String,Object>> updateGoodsForm = new ArrayList<HashMap<String,Object>>();
		Connection con = DBHelper.getConnection();
		
		PreparedStatement stmt= null;
		ResultSet rs = null;
		//sql -> 상품번호로 상품 상세보기 페이지로 넘어오기
		String sql = "select * from goods where goods_no = ?";
		stmt = con.prepareStatement(sql);
		stmt.setInt(1,goodsNo);
		rs = stmt.executeQuery();
		
		while(rs.next()){
				HashMap<String,Object> m = new HashMap<String,Object>();
			
				m.put("goodsNo",rs.getInt("goods_no"));
				m.put("category", rs.getString("category"));
				m.put("empId", rs.getString("emp_id"));
				m.put("goodsTitle", rs.getString("goods_title"));
				m.put("fileName", rs.getString("filename"));
				m.put("goodsContent", rs.getString("goods_content"));
				m.put("goodsPrice", rs.getInt("goods_price"));
				m.put("goodsAmount", rs.getInt("goods_amount"));
				m.put("updateDate", rs.getString("update_date"));
				m.put("createDate", rs.getString("create_date"));
				
				
				updateGoodsForm.add(m);
		
		}
		con.close();
		return updateGoodsForm;
	}
	public static int deleteGoodsAction(int goodsNo) throws Exception {
		int row = 0;
		Connection con = DBHelper.getConnection();
		String sql = "delete from goods where goods_no = ?";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1,goodsNo);
		
		
		
		row = stmt.executeUpdate();
		
		con.close();
		return row;
	}
	public static int addGoodsAction(String category ,String empId, int goodsPrice,int goodsAmount,String goodsTitle,String goodsContent,String filename) throws Exception{
		String sql = "insert into goods (category,emp_id,goods_price,goods_amount,goods_title,filename, goods_content,update_date,create_date) values(?,?,?,?,?,?,?,now(),now())";
		Connection con = DBHelper.getConnection();
		
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1,category);
		stmt.setString(2,empId);
		stmt.setInt(3,goodsPrice);
		stmt.setInt(4,goodsAmount);
		stmt.setString(5,goodsTitle);
		stmt.setString(6,filename);
		stmt.setString(7,goodsContent);
		
		
		int row = stmt.executeUpdate();
		
		con.close();
		return row;
	}
	public static int updateGoodsAmount(int totalAmount,int goodsNo) throws Exception{
		int row = 0;
		String sql = "update goods set goods_amount = goods_amount - ? where goods_no =?";
		Connection con = DBHelper.getConnection();
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1, totalAmount);
		stmt.setInt(2, goodsNo);
		row = stmt.executeUpdate();
		
		con.close();
		return row;
	}
	 public static int cancelGoodsAmount(int totalAmount,int goodsNo) throws Exception{
		 int row = 0;
		 String sql= "update goods set goods_amount = goods_amount + ? where goods_no =?";
		 Connection con = DBHelper.getConnection();
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setInt(1, totalAmount);
			stmt.setInt(2, goodsNo);
			row = stmt.executeUpdate();
			
			con.close();
			return row;
	 }
}
