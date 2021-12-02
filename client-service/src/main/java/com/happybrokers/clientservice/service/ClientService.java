package com.happybrokers.clientservice.service;

import com.happybrokers.clientservice.entity.Client;
import com.happybrokers.clientservice.repository.ClientRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;

@Service
@RequiredArgsConstructor
public class ClientService {

    private final ClientRepository clientRepository;

    public Client saveClient(Client client) {

        return clientRepository.save(client);
    }

    public List<Client> getAllClients() {

        return clientRepository.findAll();
    }

    public Client findByClientId(Long clientId) throws NoSuchElementException {

        return clientRepository.getById(clientId);
    }

    public Long totalClientSaved() {

        return clientRepository.count();
    }

}
