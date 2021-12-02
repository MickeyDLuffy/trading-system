package com.happybrokers.clientservice.controller;

import com.happybrokers.clientservice.entity.Client;
import com.happybrokers.clientservice.service.ClientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1")
public class ClientController {

    @Autowired
    ClientService clientService;

    @PostMapping("/clients/signup")
    public Client saveClient(@RequestBody Client client) {

        return clientService.saveClient(client);
    }

    @GetMapping("/clients/{clientId}")
    public Client getClientById(@PathVariable Long clientId) {

        return clientService.findByClientId(clientId);
    }

    @GetMapping("/clients")
    public List<Client> getAllClients() {

        return clientService.getAllClients();
    }


    /*@GetMapping("/portfolio/{id")
    public List<Portfolio> getClientPortfolio(@PathVariable Long clientId) {

        return clientService.getClientPortfolio(clientId);
    }*/
}
