package com.cjeg.test;

import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics;
import java.awt.Graphics2D;

import javax.swing.JFrame;

import org.apache.commons.lang3.RandomStringUtils;

import com.cjeg.Util.StringUtils;
import com.cjeg.consts.Consts;

import sun.font.FontDesignMetrics;

/**
 * 
 * @author 曹倩倩
 *
 * 创建时间:2017年3月3日 下午11:17:17
 *
 */
public class MyWindow extends JFrame {
	public static void main(String[] args) {
		System.out.println(StringUtils.getMD5("123456"));
		MyWindow my=new MyWindow();
		my.setVisible(true);
		my.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		my.setBounds(200,100,400,400);
	}
	
	@Override
	public void paint(Graphics g) {
		super.paint(g);
		Graphics2D g2=(Graphics2D)g;
		
		Font font=new Font("",Font.BOLD, 60);
		FontMetrics fm=FontDesignMetrics.getMetrics(font);
		;
		String str=RandomStringUtils.random(4, Consts.RANDOM_CODE);
		g2.drawRect(100, 100, 200, 100);
		g2.setFont(font);
		g2.setColor(Color.RED);
		g2.drawString(str, 100+30,100+fm.getHeight());
		
	}
}
