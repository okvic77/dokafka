// s-1vcpu-3gb 512mb

resource "digitalocean_droplet" "zookeeper" {
  ssh_keys = ["${var.ssh_keys}"]
  name = "zookeeper"
  image = "ubuntu-17-04-x64"
  region = "sfo2"
  size   = "512mb"
  private_networking = true
  resize_disk = false
  provisioner "remote-exec" {
    scripts = [
      "prov-java.sh",
      "prov-zookeeper.sh",
    ]
  }
}


resource "digitalocean_droplet" "kafka" {
  name = "kafka"
  image = "ubuntu-17-04-x64"
  region = "sfo2"
  size   = "s-1vcpu-3gb"
  private_networking = true
  resize_disk = false
  ssh_keys = ["${var.ssh_keys}"]

  provisioner "remote-exec" {
    scripts = [
      "prov-java.sh",
      "prov-kafka.sh",
    ]
  }
  provisioner "remote-exec" {
    inline = [
      "cd kafka_2.11-1.0.0; sed s/zookeeper.connect=localhost:2181/zookeeper.connect=${digitalocean_droplet.zookeeper.ipv4_address_private}:2181/g config/server-test.properties;",
    ]
  }
}

// s-1vcpu-3gb 512mb
resource "digitalocean_droplet" "kafka-consumers" {
  count = 2
  name = "kafka-consumers-${count.index}"
  image = "ubuntu-17-04-x64"
  region = "sfo2"
  size   = "s-1vcpu-3gb"
  private_networking = true
  resize_disk = false
  ssh_keys = ["${var.ssh_keys}"]

  provisioner "remote-exec" {
    scripts = [
      "prov-java.sh",
      "prov-kafka.sh",
    ]
  }
}

output "kafka" {
  value = "root@${digitalocean_droplet.kafka.ipv4_address}"
}

output "zookeeper" {
  value = "root@${digitalocean_droplet.zookeeper.ipv4_address}"
}