package cn.jxufe.websocket;

import java.util.Map;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;;

public class FarmActionInterceptor extends HttpSessionHandshakeInterceptor {
	@Override    
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response,   
            WebSocketHandler wsHandler, Map<String, Object> attributes) throws Exception {    
          
        /** 在拦截器内强行修改websocket协议，将部分浏览器不支持的 x-webkit-deflate-frame 扩展修改成 permessage-deflate */  
        if(request.getHeaders().containsKey("Sec-WebSocket-Extensions")){  
            request.getHeaders().set("Sec-WebSocket-Extensions", "permessage-deflate");  
        }  
        return super.beforeHandshake(request, response, wsHandler, attributes);    
    }    
}
