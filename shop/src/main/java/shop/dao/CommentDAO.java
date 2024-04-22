package shop.dao;

import java.sql.*;
import java.util.*;

public class CommentDAO {
	//평점 입력 DAO
	public static int insertCommentAction (int ordersNo,int score,String content) throws Exception {
		String sql = "insert into comment (orders_no,score,content,update_date,create_date) values(?,?,?,now(),now())";
		Connection con = DBHelper.getConnection();
		
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1,ordersNo);
		stmt.setInt(2,score);
		stmt.setString(3,content);
				
		int row = stmt.executeUpdate();
		
		con.close();
		return row;
	}
	//후기 이미 입력한 주문-> 후기 작성 완료 출력하기
	public static boolean checkCommentAction (int ordersNo) throws Exception {
		boolean checkComment = false;
		Connection con = DBHelper.getConnection();
		
		String sql = "select * from comment where orders_no =?";
		
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1,ordersNo);
		ResultSet rs = stmt.executeQuery();
		
		
		while(rs.next()) {
			//읽어올 행이 있다면 해당 주문의 후기가 이미 작성 된 것 -> 후기완료
			checkComment = true;
		}
			
		con.close();
		return checkComment;
		
}
	//고객 -> 자기가 쓴 후기 리스트 보기
	public static ArrayList<HashMap<String,Object>> selectCommentList (String mail)throws Exception{
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		Connection con = DBHelper.getConnection();
		String sql = "SELECT o.orders_no ordersNo,o.goods_no goodsNo, "
				+ "c.score, c.content, c.create_date createDate FROM orders o INNER JOIN comment c "
				+ "ON o.orders_no = c.orders_no WHERE o.mail = ? ORDER BY o.orders_no DESC;";
		
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1,mail);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			
			m.put("ordersNo",rs.getInt("ordersNo"));
			m.put("goodsNo", rs.getInt("goodsNo"));
			m.put("score", rs.getInt("score"));
			m.put("content", rs.getString("content"));
			m.put("createDate", rs.getString("createDate"));
			
			list.add(m);
		}
		
		con.close();
		return list;
	}
}
