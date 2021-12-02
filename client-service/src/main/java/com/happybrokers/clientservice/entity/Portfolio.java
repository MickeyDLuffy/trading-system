package com.happybrokers.clientservice.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.List;

@Entity
@Data
@AllArgsConstructor
@Table(name = "portfolios")
public class Portfolio {
    @Id
    @GeneratedValue
    private Long portfolioId;

    private String name;

    private Long clientId;

    //private List<Asset> products;
}
