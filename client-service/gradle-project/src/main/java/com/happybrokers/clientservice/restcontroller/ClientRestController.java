package com.happybrokers.clientservice.restcontroller;

import com.happybrokers.clientservice.entity.User;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/clients")
@RequiredArgsConstructor
public class ClientRestController {

    @GetMapping("/")
    public User getClients() {
        return new User("mickey", "password");
    }
}
