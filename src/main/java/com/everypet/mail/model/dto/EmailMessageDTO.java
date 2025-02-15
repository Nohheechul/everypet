package com.everypet.mail.model.dto;

import com.everypet.mail.model.constant.Purpose;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class EmailMessageDTO {

    @ApiModelProperty(example = "abc@naver.com", notes = "받는 사람 이메일")
    private String to;

    @ApiModelProperty(example = "SIGNUP", notes = "이메일 목적", allowableValues = "SIGNUP, PASSWORD_CHANGE, PASSWORD_FIND, ID_FIND, PASSWORD_RESET")
    private Purpose purpose;

}