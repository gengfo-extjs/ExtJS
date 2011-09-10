package com.baobaotao.dao.jdbc;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import oracle.jdbc.driver.OracleConnection;

import org.springframework.jdbc.LobRetrievalFailureException;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.support.AbstractLobCreatingPreparedStatementCallback;
import org.springframework.jdbc.core.support.AbstractLobStreamingResultSetExtractor;
import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.jdbc.datasource.DataSourceUtils;
import org.springframework.jdbc.support.incrementer.DataFieldMaxValueIncrementer;
import org.springframework.jdbc.support.lob.LobCreator;
import org.springframework.jdbc.support.lob.LobHandler;
import org.springframework.util.FileCopyUtils;

import com.baobaotao.dao.PostDao;
import com.baobaotao.domain.Post;

public class PostJdbcDao extends JdbcDaoSupport implements PostDao {
	private LobHandler lobHandler;
	private DataFieldMaxValueIncrementer incre;
	public LobHandler getLobHandler() {
		return lobHandler;
	}
	public void setLobHandler(LobHandler lobHandler) {
		this.lobHandler = lobHandler;
	}
	public void getNativeConn(){
		try {
			Connection conn = DataSourceUtils.getConnection(getJdbcTemplate()
					.getDataSource());
			conn = getJdbcTemplate().getNativeJdbcExtractor()
					.getNativeConnection(conn);
			OracleConnection oconn = (OracleConnection) conn;
			System.out.println(oconn.getClass().getName());
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}
	public void addPost(final Post post) {		
		String sql = " INSERT INTO t_post(post_id,user_id,post_text,post_attach)"
				+ " VALUES(?,?,?,?)";
		getJdbcTemplate().execute(
				sql,
				new AbstractLobCreatingPreparedStatementCallback(
						this.lobHandler) {
					protected void setValues(PreparedStatement ps,
							LobCreator lobCreator) throws SQLException {
						ps.setInt(1, incre.nextIntValue());	
						ps.setInt(2, post.getUserId());	
						lobCreator.setClobAsString(ps, 3, post.getPostText());
						lobCreator.setBlobAsBytes(ps, 4, post.getPostAttach());
					}
				});
	}
	public void getAttach(final int postId,final OutputStream os){
		String sql = "SELECT post_attach FROM t_post WHERE post_id=? ";
		getJdbcTemplate().query(
				sql, new Object[] {postId},
				new AbstractLobStreamingResultSetExtractor() {
					protected void handleNoRowFound() throws LobRetrievalFailureException {
						System.out.println("Not Found result!");
					}
					public void streamData(ResultSet rs) throws SQLException, IOException {
						InputStream is = lobHandler.getBlobAsBinaryStream(rs, 1);
						if (is != null) {
							FileCopyUtils.copy(is, os);
						}
					}
				}
		);
	}
	
	public List getAttachs(final int userId){
		String sql = "SELECT post_id,post_attach FROM t_post where user_id =? and post_attach is not null";
		return getJdbcTemplate().query(
			    sql,new Object[] {userId},
			    new RowMapper() {
				    public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
				    	Post post = new Post();
				    	int postId = rs.getInt(1);
					    byte[] attach = lobHandler.getBlobAsBytes(rs, 2);
					    post.setPostId(postId);
					    post.setPostAttach(attach);
					    return post;
				    }
			    });
	}
	public void setIncre(DataFieldMaxValueIncrementer incre) {
		this.incre = incre;
	}	
}
