package com.happybrokers.clientservice.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Data
@AllArgsConstructor
@Table(name = "assets")
@NoArgsConstructor
public class Asset {
    @Id
    @GeneratedValue
    private Long assetId;

    private String name;

    private String symbol;
}
