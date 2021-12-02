package com.happybrokers.clientservice.entity;

import com.happybrokers.clientservice.Statuss;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Data
@Table(name = "users")
@NoArgsConstructor
public class User {

    @Id
    @GeneratedValue
    private Long userId;

    private String name;

    private String username;

    private String password;

    private Integer role;

    private int status = Statuss.ACTIVE.getIntValue();

    private LocalDateTime createdAt = LocalDateTime.now();

    public User(String name, String username, String password, Integer role) {
        this.name = name;
        this.username = username;
        this.password = password;
        this.role = role;


        //BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        //this.password = passwordEncoder.encode(password);
    }
}
