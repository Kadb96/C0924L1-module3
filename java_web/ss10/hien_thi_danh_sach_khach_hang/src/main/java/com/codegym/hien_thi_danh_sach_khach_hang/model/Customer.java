package com.codegym.hien_thi_danh_sach_khach_hang.model;

public class Customer {
    private String name;
    private String dateOfBirth;
    private String address;
    private String profilePictureLink;

    public Customer(String name, String dateOfBirth, String address, String profilePictureLink) {
        this.name = name;
        this.dateOfBirth = dateOfBirth;
        this.address = address;
        this.profilePictureLink = profilePictureLink;
    }

    public Customer() {
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(String dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getProfilePictureLink() {
        return profilePictureLink;
    }

    public void setProfilePictureLink(String profilePictureLink) {
        this.profilePictureLink = profilePictureLink;
    }
}
