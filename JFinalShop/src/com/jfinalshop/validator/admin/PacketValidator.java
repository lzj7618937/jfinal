package com.jfinalshop.validator.admin;

import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;

public class PacketValidator extends Validator{

	@Override
	protected void validate(Controller c) {
		c.getFile();
		//validateRequiredString("packet.name", "errorMessages", "商品包名称不允许为空!");

	}

	@Override
	protected void handleError(Controller c) {
		c.render("/admin/error.html");
	}

}
