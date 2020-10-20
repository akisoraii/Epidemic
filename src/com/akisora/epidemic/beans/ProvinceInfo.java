package com.akisora.epidemic.beans;

public class ProvinceInfo {
    private Integer provinceId;
    private String provinceName;
    private String provincePY;

    public String getProvincePY() {
        return provincePY;
    }

    public void setProvincePY(String provincePY) {
        this.provincePY = provincePY;
    }

    public Integer getProvinceId() {
        return provinceId;
    }

    public void setProvinceId(Integer provinceId) {
        this.provinceId = provinceId;
    }

    public String getProvinceName() {
        return provinceName;
    }

    public void setProvinceName(String provinceName) {
        this.provinceName = provinceName;
    }

}
