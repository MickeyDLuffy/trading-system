package com.happybrokers.clientservice.entity;


import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;

import javax.persistence.Entity;
//@Entity
@Data
@AllArgsConstructor
public class ExchangeData {

    @JsonProperty("BID_PRICE")
    private Double bidPrice;

    @JsonProperty("ASK_PRICE")
    private Double askPrice;

    @JsonProperty("BUY_LIMIT")
    private Integer buyLimit;

    @JsonProperty("SELL_LIMIT")
    private Integer sellLimit;

    @JsonProperty("TICKER")
    private String ticker;

    @JsonProperty("MAX_PRICE_SHIFT")
    private Double maxPriceShift;

    @JsonProperty("LAST_TRADED_PRICE")
    private Double lastTradedPrice;

}
