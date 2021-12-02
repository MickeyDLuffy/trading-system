package com.happybrokers.clientservice.service;

import com.happybrokers.clientservice.entity.Client;
import com.happybrokers.clientservice.repository.ClientRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.*;

@ExtendWith(MockitoExtension.class)
class ClientServiceTest {

    @Mock
    private ClientRepository clientRepository;

    @InjectMocks
    private ClientService clientService;


    @Test
    void saveClient() {
        Client client = new Client("osborne", "mordreds", "osborne.mordreds@gmail.com");

        clientService.saveClient(client);

        assertThat(clientService.totalClientSaved()).isNotNull();
    }
}