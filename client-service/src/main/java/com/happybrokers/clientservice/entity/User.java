package com.happybrokers.clientservice.entity;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

import javax.persistence.Entity;
import javax.persistence.Id;

@Setter
@Getter
@RequiredArgsConstructor
public class User {

    private String username;
    private String password;
    private boolean enabled;
    public User(String username, String password) {
        this.username = username;
        this.password = password;
    }
}
