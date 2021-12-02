package com.happybrokers.clientservice.entity;

import com.happybrokers.clientservice.Statuss;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.Email;
import java.time.LocalDateTime;

@Entity
@Data
@Table(name = "clients")
@NoArgsConstructor
public class Client {

    @Id
    @GeneratedValue
    private Long id;

    private String firstname;

    private String lastname;

    private Double balance = 0.0;

    private int status = Statuss.ACTIVE.getIntValue();

    private LocalDateTime createdAt = LocalDateTime.now();

    @Column(unique=true)
    @Email
    private String email;

    public Client(String firstname, String lastname, String email) {
        this.firstname = firstname;
        this.lastname = lastname;
        this.email = email;
    }

}
