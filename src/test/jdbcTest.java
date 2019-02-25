import com.hit.mtweb.controller.UserController;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;

public class jdbcTest {

    ApplicationContext ctx = new FileSystemXmlApplicationContext("/src/main/webapp/WEB-INF/applicationContext.xml");
    JdbcTemplate jdbcTemplate = (JdbcTemplate) ctx.getBean("jdbcTemplate");

    @Test
    public void updateTest(){
        String sql = "UPDATE users set password = ? Where username = ?";
        jdbcTemplate.update(sql,"1234567","hxx");
    }

    @Test
    public void testGetUsers(){
        UserController userController = new UserController();
        System.out.println(userController.viewAllUsers());
    }

}
