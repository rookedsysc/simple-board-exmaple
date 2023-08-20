package com.example.simpleboard.common;

import lombok.Getter;
import lombok.Setter;

public interface EntityBase {
  String status = "REGISTERED";
  String getStatus();
  void setStatus(String status);
}
