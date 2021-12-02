package com.happybrokers.clientservice;

public enum Statuss {
    ACTIVE(1), INACTIVE(2), SUSPENDED(3), DELETED(4);

    public int getIntValue() {
        return intValue;
    }

    public int intValue;

    Statuss(int i) {
        intValue = i;
    }
}
