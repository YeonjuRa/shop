package shop.dao;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
public class OrderDAO {
	public static int addOrderAction (String mail,int goodsNo,int totalAmount,int totalPrice,String address) throws Exception{
		Connection con = DBHelper.getConnection();
		
		String sql = "insert into orders (mail,goods_no,total_amount,total_price,address, state,update_date,create_date) values(?,?,?,?,?,'결제 완료',now(),now())";
		
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1,mail);
		stmt.setInt(2,goodsNo);
		stmt.setInt(3,totalAmount);
		stmt.setInt(4,totalPrice);
		stmt.setString(5,address);
	
		
		
		int row = stmt.executeUpdate();
		
		con.close();
		return row;
	}
	//고객 주문 리스트 출력하기 
	public static ArrayList<HashMap<String,Object>> selectOrdersList (String mail)throws Exception{
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		Connection con = DBHelper.getConnection();
		String sql = "select o.orders_no ordersNo,o.goods_no goodsNo, g.goods_title goodsTitle,"
				+ " o.total_amount totalAmount, o.total_price totalPrice,o.state state, o.create_date createDate "
				+ "from orders o inner join goods g on o.goods_no = g.goods_no "
				+ "where o.mail =? order by o.orders_no DESC";
		
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1,mail);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			
			m.put("ordersNo",rs.getInt("ordersNo"));
			m.put("goodsNo", rs.getInt("goodsNo"));
			m.put("goodsTitle", rs.getString("goodsTitle"));
			m.put("totalAmount", rs.getInt("totalAmount"));
			m.put("totalPrice", rs.getInt("totalPrice"));
			m.put("state", rs.getString("state"));
			m.put("createDate", rs.getString("createDate"));
			
			list.add(m);
		}
		
		con.close();
		return list;
	}
	//관리자 전체주문을 확인 
	public static ArrayList<HashMap<String,Object>> selectOrdersListAll ()throws Exception{
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		Connection con = DBHelper.getConnection();
		String sql = "select o.orders_no ordersNo,o.goods_no goodsNo, g.goods_title goodsTitle,"
				+ " o.total_amount totalAmount, o.total_price totalPrice,o.state state, o.create_date createDate "
				+ "from orders o inner join goods g on o.goods_no = g.goods_no "
				+ " order by o.orders_no DESC";
		
		PreparedStatement stmt = con.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			
			m.put("ordersNo",rs.getInt("ordersNo"));
			m.put("goodsNo", rs.getInt("goodsNo"));
			m.put("goodsTitle", rs.getString("goodsTitle"));
			m.put("totalAmount", rs.getInt("totalAmount"));
			m.put("totalPrice", rs.getInt("totalPrice"));
			m.put("state", rs.getString("state"));
			m.put("createDate", rs.getString("createDate"));
			
			list.add(m);
		}
		
		con.close();
		return list;	
	}
	public static int updateStateAction (String state, int ordersNo) throws Exception {
		Connection con = DBHelper.getConnection();
		
		String sql = "update orders set state = ? where orders_no =?";
		
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1,state);
		stmt.setInt(2,ordersNo);
	
		
		int row = stmt.executeUpdate();
		
		con.close();
		return row;
	}
	public static ArrayList<HashMap<String,Object>> selectOrderOne (int ordersNo)throws Exception{
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		Connection con = DBHelper.getConnection();
		String sql = "select o.orders_no ordersNo,o.goods_no goodsNo, g.goods_title goodsTitle, g.filename filename, "
				+ " o.total_amount totalAmount, o.total_price totalPrice,o.state state, o.create_date createDate "
				+ "from orders o inner join goods g on o.goods_no = g.goods_no "
				+ "where o.orders_no =?";
		
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1,ordersNo);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			
			m.put("ordersNo",rs.getInt("ordersNo"));
			m.put("goodsNo", rs.getInt("goodsNo"));
			m.put("goodsTitle", rs.getString("goodsTitle"));
			m.put("filename", rs.getString("filename"));
			m.put("totalAmount", rs.getInt("totalAmount"));
			m.put("totalPrice", rs.getInt("totalPrice"));
			m.put("state", rs.getString("state"));
			m.put("createDate", rs.getString("createDate"));
			
			list.add(m);
		}
		
		con.close();
		return list;
	}
		
		public static int cancelOrderActoin (int ordersNo) throws Exception {
			Connection con = DBHelper.getConnection();
			
			String sql = "update orders set state='취소 완료' where orders_no =? and state ='결제 완료'";

			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setInt(1,ordersNo);
			
		
			
			int row = stmt.executeUpdate();
			
			con.close();
			return row;
		}
	

	
}
	

