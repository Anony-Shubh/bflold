package pkgPmegpNew;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CaptchaServlet extends HttpServlet {
    public static final String CAPTCHA_KEY = "captcha_key";
    private int width = 150;
    private int height = 50;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setHeader("Cache-Control", "no-cache, no-store");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
        response.setContentType("image/jpeg");

        BufferedImage bufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D g2d = null;
        OutputStream outputStream = null;
        
        try {
            g2d = bufferedImage.createGraphics();

            // White background
            g2d.setColor(Color.WHITE);
            g2d.fillRect(0, 0, width, height);

            // Generate random string
            String captcha = generateCaptcha(6);
            
            // Store in session
            HttpSession session = req.getSession(true);
            session.setAttribute(CAPTCHA_KEY, captcha);

            // Add noise and draw text
            addNoise(g2d, 0.5f);
            drawText(g2d, captcha);
            addNoise(g2d, 0.1f);
            
            // Draw border
            g2d.setColor(Color.BLACK);
            g2d.drawRect(0, 0, width-1, height-1);
            
            // Write image to response
            outputStream = response.getOutputStream();
            ImageIO.write(bufferedImage, "jpeg", outputStream);
            outputStream.flush();
            
        } finally {
            if (g2d != null) {
                g2d.dispose();
            }
            if (outputStream != null) {
                try { outputStream.close(); } catch (IOException e) { /* ignore */ }
            }
        }
    }
    
    private String generateCaptcha(int length) {
        String chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        Random rnd = new Random();
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            sb.append(chars.charAt(rnd.nextInt(chars.length())));
        }
        return sb.toString();
    }
    
    private void drawText(Graphics2D g2d, String text) {
        g2d.setColor(Color.BLACK);
        g2d.setFont(new Font("Arial", Font.BOLD, 30));
        
        int x = 20;
        int y = 35;
        
        for (int i = 0; i < text.length(); i++) {
            // Add some random rotation
            double theta = Math.toRadians((Math.random() * 30) - 15);
            g2d.rotate(theta, x, y);
            
            // Draw the character
            g2d.drawString(String.valueOf(text.charAt(i)), x, y);
            
            // Reset rotation
            g2d.rotate(-theta, x, y);
            
            // Move to the next position
            x += 20;
        }
    }
    
    private void addNoise(Graphics2D g2d, float intensity) {
        Random random = new Random();
        for (int x = 0; x < width; x++) {
            for (int y = 0; y < height; y++) {
                if (random.nextFloat() < intensity) {
                    g2d.setColor(new Color(
                        random.nextInt(255),
                        random.nextInt(255),
                        random.nextInt(255),
                        random.nextInt(255)
                    ));
                    g2d.drawLine(x, y, x, y);
                }
            }
        }
    }
}