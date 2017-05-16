package server;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.support.GenericXmlApplicationContext;

import com.demo.common.DateUtil;

/**
 * Dubbo server.
 * 
 * @author <a href="mailto:honglei.chen@ikang.com">honglei</a>
 * @version 1.0, 5/08/2017
 */
public class DubboServer {

	/** slf4j logger api */
	protected static final Logger logger = LoggerFactory.getLogger(DubboServer.class);
    
	private static volatile boolean running = true;

    public static void main(String[] args) {
        try {
            long beginTime = System.currentTimeMillis();
    		String activeProfile = "dev";
    		if (args != null && args.length > 0) {
    			activeProfile = args[0];
    		}
    		logger.info("======profile: {} ======", activeProfile);
    		
    		String currentpath = System.getProperty("user.dir");
    		
    		final GenericXmlApplicationContext applicationContext = new GenericXmlApplicationContext();
    		applicationContext.getEnvironment().setActiveProfiles(activeProfile);
    		applicationContext.load("classpath:/conf/spring-config.xml");
    		
            Runtime.getRuntime().addShutdownHook(new Thread() {
                public void run() {
                	try {
                		applicationContext.stop();
                		applicationContext.close();
                        logger.info("======Dubbo service server stopped======");
                        System.out.println(new SimpleDateFormat("[yyyy-MM-dd HH:mm:ss]").format(new Date()) + " Dubbo service server stopped!");
                    } catch (Throwable t) {
                        logger.error(t.getMessage(), t);
                    }
                    synchronized (DubboServer.class) {
                        running = false;
                        DubboServer.class.notify();
                    }
                }
            });
    		applicationContext.refresh();
            applicationContext.start();
            logger.info("======Dubbo service server[{}] started in: {} ms======", activeProfile, (System.currentTimeMillis() - beginTime));
            System.out.println(DateUtil.formatDatetime(new Date()) + " Current Path : "+ currentpath);
            System.out.println(DateUtil.formatDatetime(new Date()) + " Dubbo service server started!");
        } catch (RuntimeException e) {
            logger.error(e.getMessage(), e);
            System.exit(1);
        }
        synchronized (DubboServer.class) {
            while (running) {
                try {
                	DubboServer.class.wait();
                } catch (Throwable e) { }
            }
        }
    }
}
