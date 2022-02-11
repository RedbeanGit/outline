import { observer } from "mobx-react";
import * as React from "react";
import styled from "styled-components";
import Scrollable from "~/components/Scrollable";
import useStores from "~/hooks/useStores";
import { NavigationNode } from "~/types";
import Sidebar from "./Sidebar";
import Section from "./components/Section";
import DocumentLink from "./components/SharedDocumentLink";

type Props = {
  rootNode: NavigationNode;
  shareId: string;
};

function SharedSidebar({ rootNode, shareId }: Props) {
  const { documents } = useStores();

  return (
    <Sidebar>
      <ScrollContainer flex>
        <Section>
          <DocumentLink
            index={0}
            shareId={shareId}
            depth={1}
            node={rootNode}
            activeDocument={documents.active}
          />
        </Section>
      </ScrollContainer>
    </Sidebar>
  );
}

const ScrollContainer = styled(Scrollable)`
  padding-bottom: 16px;
`;

export default observer(SharedSidebar);